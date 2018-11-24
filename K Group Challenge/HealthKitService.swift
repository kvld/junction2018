//
//  HealthKitService.swift
//  K Group Challenge
//
//  Created by Filipp Fediakov on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import Foundation
import HealthKit

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
                                                       HKObjectType.workoutType()]
        //4. Request Authorization
        store.requestAuthorization(toShare: [],
                                             read: healthKitTypesToRead) {
                                                (success, error) in
                                                completion(success, error)
        }
    }
}


