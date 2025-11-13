:params {
    id_variant: "awesome_bike_well_constrained", 
    scoring: [
        {
          field: "cost",
          factor: -1000
        },
        {
          field: "weight",
          factor: -1
        }
    ],
    constraints: [
        {
            category: "wheel_size",
            properties: [
                {
                    name: "wheel_size",
                    type: "float",
                    description: "Size of the wheel in inches",
                    allow_list: [
                        26.0
                    ]
                }
            ]
        },
        {
            category: "rim",
            properties: [
                {
                    name: "material",
                    type: "string",
                    description: "material of the rim",
                    allow_list: [
                        "Carbon"
                    ]
                }
            ]
        },
        {
            category: "tire",
            properties: [
                {
                    name: "pattern",
                    type: "string",
                    description: "Type of tire",
                    allow_list: [
                        "Knobby"
                    ]
                }
            ]
        },
        {
            category: "frame_material",
            properties: [
                {
                    name: "material",
                    type: "string",
                    description: "frame material",
                    deny_list: [
                        "Carbon Fiber", "Steel"
                    ]
                }
            ]
        },
        {
            category: "color",
            properties: [
                {
                    name: "color",
                    type: "string",
                    description: "color of the bike",
                    allow_list: [
                       "Black Paint"
                    ]
                }
            ]
        },
        {
            category: "caliper",
            properties: [
                {
                    name: "caliper",
                    type: "string",
                    description: "Type of caliper",
                    allow_list: [
                        "Mechanical"
                    ]
                }
            ]
        },
        {
            category: "shifter",
            properties: [
                {
                    name: "shifter",
                    type: "string",
                    description: "Type of Shifter",
                    allow_list: [
                        "Trigger"
                    ]
                }
            ]
        },
        {
            category: "derailleur",
            properties: [
                {
                    name: "derailleur",
                    type: "string",
                    description: "Type of Derailleur",
                    allow_list: [
                        "Advanced"
                    ]
                }
            ]
        },
        {
            category: "gear_system",
            properties: [
                {
                    name: "gear_system",
                    type: "string",
                    description: "gear system type",
                    allow_list: [
                        "12-Speed"
                    ]
                }
            ]
        }
    ]
}