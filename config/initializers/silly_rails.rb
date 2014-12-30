ActionView::PartialRenderer.class_eval do
    def retrieve_variable(path, as)
      variable = as || begin
        base = path[-1] == "/" ? "" : File.basename(path)
        #raise_invalid_identifier(path) unless base =~ /\A_?([a-z]\w*)(\.\w+)*\z/
        raise_invalid_identifier(path) unless base =~ /\A_?(([a-z]|[a-zA-Z0-9]|_|-)*)(\.\w+)*\z/
        $1.to_sym
      end
      if @collection
        variable_counter = :"#{variable}_counter"
        variable_iteration = :"#{variable}_iteration"
      end
      [variable, variable_counter, variable_iteration]
    end
end
