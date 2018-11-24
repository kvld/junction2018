//
//  HealthKitService.swift
//  K Group Challenge
//
//  Created by Filipp Fediakov on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import Foundation
import HealthKit

struct HealthKitStaticData {
    let age: Int
    let gender: Sex
}

enum Sex {
    case female, male, other

    var stringRepresentation: String {
        switch self {
        case .female: return "Female"
        case .male: return "Male"
        case .other: return "Other"
        }
    }
}

extension HKBiologicalSex {
    var commonSex: Sex {
        switch self {
        case .female: return .female
        case .male: return .male
        case .notSet, .other: return .other
        }
    }
}

enum HealthKitServiceError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
}

class HealthKitService {


    private let store = HKHealthStore()

    func authorize(completion: @escaping(Bool, Error?) -> ()) {
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthKitServiceError.notAvailableOnDevice)
            return
        }

        //2. Prepare the data types that will interact with HealthKit
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
            let fatPercentage = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage),
            let activity = HKObjectType.quantityType(forIdentifier: .appleExerciseTime),
            let basalEnergy = HKObjectType.quantityType(forIdentifier: .basalEnergyBurned),
            let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {

                completion(false, HealthKitServiceError.dataTypeNotAvailable)
                return
        }

//        //3. Prepare a list of types you want HealthKit to read and write
//        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
//                                                        activeEnergy,
//                                                        HKObjectType.workoutType()]

        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       fatPercentage,
                                                       bodyMass,
                                                       activity,
                                                       activeEnergy,
                                                       basalEnergy,
                                                       HKObjectType.workoutType()]
        //4. Request Authorization
        store.requestAuthorization(toShare: [],
                                             read: healthKitTypesToRead) {
                                                (success, error) in
                                                completion(success, error)
        }
    }

    func getAgeSexAndBloodType() throws -> HealthKitStaticData {
            do {

                //1. This method throws an error if these data are not available.
                let birthdayComponents =  try store.dateOfBirthComponents()
                let biologicalSex =       try store.biologicalSex()

                //2. Use Calendar to calculate age.
                let today = Date()
                let calendar = Calendar.current
                let todayDateComponents = calendar.dateComponents([.year],
                                                                  from: today)
                let thisYear = todayDateComponents.year!
                let age = thisYear - birthdayComponents.year!

                //3. Unwrap the wrappers to get the underlying enum values.
                let unwrappedBiologicalSex = biologicalSex.biologicalSex.commonSex


                return HealthKitStaticData(age: age, gender: unwrappedBiologicalSex)
            }
    }

    /// Returns most recorded recent height
    ///
    /// - Parameter completion: Double - Height in Metres
    func getHeight(completion: @escaping(Double?, Error?) -> ()) {
        //1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }
        getMostRecentSample(for: heightSampleType) { (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    completion(nil, error)
                }
                return
            }


            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            completion(heightInMeters, error)
        }
    }

    /// Returns most recorded recent mass
    ///
    /// - Parameter completion: Double - Mass in Kilos
    func getMass(completion: @escaping(Double?, Error?) -> ()) {
        //1. Use HealthKit to create the Height Sample Type
        guard let massSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Mass Sample Type is no longer available in HealthKit")
            return
        }

        getMostRecentSample(for: massSampleType) { (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    completion(nil, error)
                }
                return
            }


            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let massInKilos = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            completion(massInKilos, error)
        }
    }

    /// Return Kilocalories for resting energy
    ///
    func getRestingEnergy(completion: @escaping(Double?, Error?) -> ()) {
        guard let restingEnergySampleType = HKSampleType.quantityType(forIdentifier: .basalEnergyBurned) else {
            print("Resting Sample Type is no longer available in HealthKit")
            return
        }


        getStatisticsMonth(for: restingEnergySampleType) { (statistics, numberOfDays, error) in
            guard let statistics = statistics else {
                if let error = error {
                    completion(nil, error)
                }
                return
            }

            if let sum = statistics.sumQuantity()?
                .doubleValue(for: HKUnit.kilocalorie()) {
                let average = sum / Double(numberOfDays)
                completion(average, error)
            } else {
                completion(nil, error)
            }
        }
    }

    /// Return Kilocalories for resting energy
    ///
    func getActiveEnergy(completion: @escaping(Double?, Error?) -> ()) {
        guard let activeEnergySampleType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Mass Sample Type is no longer available in HealthKit")
            return
        }

        getStatisticsMonth(for: activeEnergySampleType) { (statistics, numberOfDays, error) in
            guard let statistics = statistics else {
                if let error = error {
                    completion(nil, error)
                }
                return
            }

            if let sum = statistics.sumQuantity()?
                .doubleValue(for: HKUnit.kilocalorie()) {
                let average = sum / Double(numberOfDays)
                completion(average, error)
            } else {
                completion(nil, error)
            }
        }
    }

    private func numberOfDays(from: Date, to: Date) -> Int? {
        let calendar = Calendar.current

        let components = calendar.dateComponents([.day], from: from, to: to)
        return components.day
    }

    private func getStatisticsMonth(for sampleType: HKQuantityType, completion: @escaping (HKStatistics?, Int, Error?) -> Void) {
        let now = Date()
        let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: now)!
        let numberOfDaysInMonth = numberOfDays(from: monthAgo, to: now) ?? 30


        let lastMonthPredicate = HKQuery.predicateForSamples(withStart: monthAgo,
                                                              end: now,
                                                              options: .strictEndDate)

        let query = HKStatisticsQuery.init(quantityType: sampleType, quantitySamplePredicate: lastMonthPredicate, options: .cumulativeSum) { (query, statistics, error) in
            DispatchQueue.main.async {
                guard let statistics = statistics else {
                    completion(nil, 0, error)
                    return
                }

                completion(statistics, numberOfDaysInMonth, nil)
            }
        }

        store.execute(query)
    }

    private func getMostRecentSample(for sampleType: HKSampleType,
                                   completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {

        //1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)

        let limit = 1


        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in

                                            //2. Always dispatch to the main thread when complete.
                                            DispatchQueue.main.async {

                                                guard let samples = samples,
                                                    let mostRecentSample = samples.first as? HKQuantitySample else {

                                                        completion(nil, error)
                                                        return
                                                }

                                                completion(mostRecentSample, nil)
                                            }
        }

        store.execute(sampleQuery)
    }
}


