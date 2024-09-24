'use strict'

class UserController 
{
    static get inject()
    {
        return [
            'App/Models/User'
        ]
    }

    constructor(User)
    {
        this.User = User
    }

    async index({ response }) 
    {
        const users = await this.User.all();
        return response.json(users);
    }
    
    async store({ request, response }) 
    {
      const { username, email, password } = request.all();
      const user = await this.User.create({ username, email, password });
      return response.status(201).json(user);
    }
  
    async show({ params, response }) 
    {
      const user = await this.User.find(params.id);
      return response.json(user);
    }
  
    async update({ params, request, response }) 
    {
      const user = await this.User.find(params.id);
      user.merge(request.all());
      await user.save();
      return response.json(user);
    }
  
    async destroy({ params, response }) 
    {
      const user = await this.User.find(params.id);
      await user.delete();
      return response.status(204).send();
    }
}

module.exports = UserController
