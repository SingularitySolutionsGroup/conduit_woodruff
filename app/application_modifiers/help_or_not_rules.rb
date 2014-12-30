module HelpOrNotRules
  include ApplicationModifierRule

  HELP_WANTED_FIELD = 'wants_help'
  NO_HELP_ONLY_TAGS = ['No Help Only', 'show no help']
  HELP_ONLY_TAGS    = ['Help Only', 'show help']

  def self.run lead, application
    return unless lead && application
    steps_to_hide_considering(lead, application).each do |step|
      step.is_hidden = true
      step.status = "Complete"
    end
  end

  class << self

    def help_is_wanted? lead
      value = lead['data'] ? lead['data'][HELP_WANTED_FIELD] : lead[HELP_WANTED_FIELD]
      ['yes', 'Yes', true, '(+)'].include?(value) || value.to_s.include?('(+)')
    end

    private

    def steps_to_hide_considering lead, application
      tags = tags_to_remove_considering(lead)
      tags.map do |tag|
        ApplicationModifierRule.steps_that_match_tag_from tag, application
      end.flatten
    end

    def tags_to_remove_considering lead
      help_is_wanted?(lead) ? NO_HELP_ONLY_TAGS : HELP_ONLY_TAGS
    end

  end
end
