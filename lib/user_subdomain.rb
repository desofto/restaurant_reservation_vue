class UserSubdomain
  def self.matches? request
    case request.subdomain
    when 'admin'
      false
    else
      true
    end
  end
end
