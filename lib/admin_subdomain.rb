class AdminSubdomain
  def self.matches? request
    case request.subdomain
    when 'admin'
      true
    else
      false
    end
  end
end
