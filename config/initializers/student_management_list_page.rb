Interchangeable.define(StudentManagementListPage, :search_options) do
  [
    [ 'email',        'Email'      ],
    [ 'hive_lead_id', 'Lead ID'    ],
    [ 'first_name',   'First Name' ],
    [ 'last_name',    'Last Name'  ],
    [ 'agent_name',   'Agent Name' ],
    [ 'status_title', 'Status' ],
  ].map { |x| Struct.new(:search_type, :text).new(*x) }
end

Interchangeable.define(StudentManagementListPage, :fields) do
  [
    [ 'Last Name',     'last_name'        ],
    [ 'First Name',    'first_name'       ],
    [ 'Email',         'email'            ],
    [ 'Agent Name',    'agent_name'       ],
    [ 'Lead Date',     'create_date'      ],
    [ 'Last Activity', 'last_activity_at' ],
    [ 'Status',        'status_title'     ],
    [ 'Campus',        'campus_of_interest' ],
  ].map { |x| Struct.new(:title, :name).new(*x) }
end

