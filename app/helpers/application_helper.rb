# frozen_string_literal: true

module ApplicationHelper
end

# Navigation bar active path setter

def active_class(path)
  if request.path == path
    return 'active'
  else
    return ''
  end
end
