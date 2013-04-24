class ReduClient
  def initialize(access_token, space_id)
    @space_id = space_id
    @access_token = access_token
  end

  def create_canvas(url, name)
    attrs = { :canvas => { :current_url => url, :name => name } }
    connection.post("api/spaces/#{@space_id}/canvas", attrs)
  end

  def first_subject_id
    response = connection.get("api/spaces/#{@space_id}/subjects")
    response.body.first["id"]
  end

  def remove_canvas(canvas_id)
    connection.delete("api/canvas/#{canvas_id}")
  end

  def create_subject(name)
    attrs = { :subject => { :name => name } }
    connection.post("api/spaces/#{@space_id}/subjects", attrs)
  end

  def create_lecture(subject_id, name, url)
    attrs = { :lecture => { :name => name, :current_url => url, :type => 'Canvas' } }
    connection.post("api/subjects/#{subject_id}/lectures", attrs)
  end

  def get_space
    connection.get("api/spaces/#{@space_id}")
  end

  def post_wall_space(canvas)
    attrs = { :status => { :text => "Existe um novo link em nosso Canvas! Acesse: http://www.redu.com.br/espacos/#{@space_id}/canvas/#{canvas}" } }
    connection.post("api/spaces/#{@space_id}/statuses", attrs)
  end

  def update_role(user_uid)
    response = connection.get("api/spaces/#{@space_id}/users?role=member")
    body = JSON.parse(response.body)

    selection = []
    unless body.empty?
      selection = body.select{ |item| item["id"] == user_uid }
    end

    if selection.empty?
      User.find_by_uid(user_uid).update_attributes({ role: "teacher" })
    else
      User.find_by_uid(user_uid).update_attributes({ role: "member" })
    end
  end

  def connection
    @conn ||= Faraday.new(:url => 'http://redu.com.br') do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.headers['Authorization'] = "OAuth #{@access_token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end

# client = ReduClient.new(User.first.access_token, 2467)
# client.create_canvas(2467, "http://www.redu.com.br", "Meu canvas")
