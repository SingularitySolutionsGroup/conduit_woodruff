Refinery::User.class_eval do
  def self.user_ids_interested_in user_event
    Refinery::Role.where(title: 'Rep').map { |x| x.users.map { |x| x.id } }.flatten
  end
end
