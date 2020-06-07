
//
//  ViewController.swift
//  DecodeValue
//
//  Created by outofcoding on 06/07/2020.
//  Copyright (c) 2020 outofcoding. All rights reserved.
//

import UIKit
import DecodeValue

struct Job : Decodable {
    var name: JSONString
}

struct People : Decodable {
    var name: JSONString?
    var age: JSONInt
    var job: JSONDictionary<Job>
    var jobs: JSONArray<Job>?
}

struct KoreaPeople : Decodable {
    var name: JSONValue<String>
    var age: JSONValue<Int>
}

class ViewController: UIViewController {
    
    private var data = """
{
    "name": "OutOfCoding",
    "age": 20,
    "job": {
        "first": {
            "name":"engineer"
        }
    },
    "jobsa": [
        {
            "name":"power"
        }
    ]
}
""".data(using: .utf8)!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var saveName: String = ""
        
        if let people = decode(People.self, from: data) {
            let name = people.name*.count // or use people.name.valueOrEmpty.count
            let age = people.age* // or use people.age.value
            print("name count = \(name), age = \(age)")
            // result : name count = 11, age = 20
            
            let job = people.job.value["first"]
            let jobName = job?.name*
            print("job1 name = \(jobName.or("No job"))")
            // result : job1 name = engineer
            
            let jobfirst = people.jobs*.first
            let jobfirstName = jobfirst?.name*
            print("job2 name = \(jobfirstName.or("No job"))")
            // result : job2 name = No job
            
            saveName <~ people.name // saveName = people.name.value
        }
        
        print("saveName = \(saveName)")
        // result : saveName = "OutOfCoding"
        
        var tempName: String?

        if let koreaPeople = decode(KoreaPeople.self, from: data) {
            let name = koreaPeople.name* // or use koreaPeople.name.value. this value is Optional
            let age = koreaPeople.age* // or user koreaPeople.age.value. this value is Optional
            print("name = \(name.or("None")), age = \(age.or(0))") // using or
            // result : name = OutOfCoding, age = 20
            
            tempName <~ koreaPeople.name // tempName = koreaPeople.name.value
        }
        
        print("tempName = \(tempName.or("Cool"))")
        // result : tempName = Optional("OutOfCoding")
    }
    
    private func decode<T>(_ type: T.Type, from data: Data) -> T? where T : Decodable {
        if let response = try? JSONDecoder().decode(type.self, from: data) {
            return response
        } else {
            return nil
        }
    }
}
