DateMapper = require 'src/mapper/api/type/Date'

UserModel = require 'src/model/User'

class User

  @marshall: (user) ->

    throw new Error 'Invalid user' unless user instanceof UserModel

    data = {}
    data.id = user.id if user.id?
    data.first_name = user.first_name if user.first_name?
    data.last_name = user.last_name if user.last_name?
    data.email = user.email if user.email?
    data.created = DateMapper.marshall user.createdAt if user.createdAt?

    return data


  @unmarshall: (data, user) ->

    throw new Error 'Invalid user data' unless data?

    if typeof user isnt 'undefined' and user not instanceof UserModel
      throw new Error 'Invalid user'

    initData = {}
    initData.first_name = data.first_name if data.first_name?
    initData.last_name = data.last_name if data.last_name?

    user = user || new UserModel initData

    user.setEmail data.email if data.email?
    user.setPassword data.password if data.password?

    return user


module.exports = User