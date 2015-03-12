module APIHelper

  def set_class classname
    @classname = classname
    @url_object = create(class_sym)
  end

  def get_user_id
    @current_user.id
  end

  def get_organization_id
    @current_user.organizations.first.id
  end

  def class_sym 
    @classname.to_sym
  end

  def class_plural_sym
    (@classname+'s').to_sym
  end

  def set_header user
    @current_user = user
    header 'Authorization', "Bearer #{user.aquire_api_key.token}"
    header 'Organization-id', user.organizations.first.id
  end

  def create_user_and_set_header
    user = create(:user) 
    set_header user
  end

  def get_url
    "v1/"+@classname+"s"
  end

  def get_id_url
    get_url + "/#{@url_object.id}"
  end

  def get_test
    get get_url
    expect( last_response.status ).to be == 200
    expect( json ).to have_key(class_plural_sym)
  end

  def get_id_test
    get get_id_url
    expect( last_response.status ).to be == 200
    expect( json ).to have_key(class_sym)
    expect( json[@classname] ).to have_key(:id)
  end

  def delete_test
    delete get_id_url
    expect( last_response.status ).to be == 200 
    expect( json ).to eq({})
  end

end