Interchangeable.define(StudentManagementDetailPage, :fields) do
  [
    { type: 'lead_id' },
    { type: 'email' },
    { type: 'field', data: { field: 'phone' } },
    { type: 'field', data: { field: 'status_title',        label: 'Status' } },
    { type: 'field', data: { field: 'program_of_interest', label: 'Program' } },
    { type: 'field', data: { field: 'agent_name',          label: 'Agent Name' } },
    { type: 'field', data: { field: 'disc_type',           label: 'DISC' } },
    { type: 'application' },
  ]
end
