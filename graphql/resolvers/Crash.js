// import Crash from '../../models/Crash.js'

// async set up for db calls (for later)
// export default {
//     Query: {
//         crash: async (root, args) => await Crash.findOne(args).exec(),
//         crashes: async () => Crash.find({}).populate().exec()
//     }
// }


// dummy data instead of db for now
// @TODO: confirm that COLLISION and VEHICLE_CO don't need to be arrays
const dummyData = [
    {
        CRN: '1',
        MAX_SEVERI: 'Killed',
        COUNTY: 'Bucks',
        MUNICIPALITY: 'Samsquantch',
        VEHICLE_CO: {
            "BICYCLE_CO": '73',
            "SMALL_TRUC": ' 40',
            "MOTORCYCLE": '132'
        },
        COLLISION: {
            "Angle": '45',
            "NonCollision": 'true',
            "RearEnd": 'true',
            "RearToRearBacking": "false"
        }
    },
    {
        CRN: '2',
        MAX_SEVERI: 'Killed',
        COUNTY: 'Bucks',
        MUNICIPALITY: 'Other',
        VEHICLE_CO: {
            "AUTOMOBILE": '6',
            "PERSON_COU": '98',
            "MOTORCYCLE": '1'
        },
        COLLISION: {
            "HitFixedObject": "yes?",
            "RearEnd": "true",
            "NonCollision": "false"
        }
    },
    {
        CRN: '3',
        MAX_SEVERI: 'Moderate injury',
        COUNTY: 'Delaware',
        MUNICIPALITY: 'What are these',
        VEHICLE_CO: {
            "PERSON_COU": '1', 
            "BICYCLE_CO": '68',
            "AUTOMOBILE": '12'
        },
        COLLISION: {
            "RearEnd": "true",
            "Angle": "45",
            "HeadOne": "false",
            "NonCollision": "false"
        }
    },
    {
        CRN: '4',
        MAX_SEVERI: 'Moderate injury',
        COUNTY: 'Montgomery',
        MUNICIPALITY: 'Ardmore',
        VEHICLE_CO: {
            "SMALL_TRUC": '4',
            "MOTORCYCLE": '1'
        },
        COLLISION: {
            "HitPedestrian": "false",
            "NonCollision": "false",
            "Angle": "192"
        }
    },
    {
        CRN: '5',
        MAX_SEVERI: 'Minor injury',
        COUNTY: 'Montgomery',
        MUNICIPALITY: 'Ardmore',
        VEHICLE_CO: {
            "HEAVY_TRUC": '12',
            "MOTORCYCLE": '4',
            "VAN_COUNT": "38"
        },
        COLLISION: {
            "NonCollision": "true",
            "HeadOn": "true",
            "SideswipeSameDir": "true"
        }  
    },
    {
        CRN: '6',
        MAX_SEVERI: 'Killed',
        COUNTY: 'Chester',
        MUNICIPALITY: 'Chester',
        VEHICLE_CO: {
            "AUTOMOBILE": '120',
            "MOTORCYCLE": '40',
            "VAN_COUNT": "3"
        },
        COLLISION: {
            "HeadOn": "true",
            "NonCollision": "false",
            "RearToRearBacking": "true"
        }  
    }
]

export default {
    Query: {
        // allow users to grab an individual crash by id (to simulate clicking on one) I don't know why this always returns null but crashes works...
        crash: (parent, args, context, info) => dummyData.filter(data => data.CRN === args.CRN),
        
        // allow users to build granular queries and get all crashes associated w/selected variables (early stages of the main query modal)
        crashes: (parent, args, context, info) => {
            return dummyData.filter(crash => {
                const id = args.CRN || null
                const severity = args.MAX_SEVERI || null
                const county = args.COUNTY || null
                const municipality = args.MUNICIPALITY || null 
                
                // entities are an array of options, want to get any crash that satisfies any one of them
                // the idea is to search for even a single common feature, short out if yes and return a bool that goes into the ridiculous || chain below
                const entities = args.VEHICLE_CO || null
                let entitiesBool = false

                if(entities){
                    const length = entities.length
                    // for loop here in order to break as soon as a match is found
                    for(var i = 0; i < length; i++){
                        if(crash.VEHICLE_CO.contains(entities[i])){
                            entitiesBool = true
                            break
                        }
                    }
                }

                // return any crash that matches any of the fields
                return crash.CRN === id || crash.MAX_SEVERI === severity || crash.COUNTY === county || crash.MUNICIPALITY === municipality || entitiesBool
            })
        }
    }
}