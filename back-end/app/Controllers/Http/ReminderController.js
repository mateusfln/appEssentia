'use strict'

class ReminderController 
{
    static get inject()
    {
        return [
            'App/Models/Reminder'
        ]
    }

    constructor(Reminder)
    {
        this.Reminder = Reminder
    }

    async index({ response }) 
    {
        const reminders = await this.Reminder.all();
        return response.json(reminders);
    }
    
    async store({ request, response }) 
    {
      const { title, description, observations, timetable } = request.all();
      const reminder = await this.Reminder.create({ title, description, observations, timetable });
      return response.status(201).json(reminder);
    }
  
    async show({ params, response }) 
    {
      const reminder = await this.Reminder.find(params.id);
      return response.json(reminder);
    }
  
    async update({ params, request, response }) 
    {
      const reminder = await this.Reminder.find(params.id);
      reminder.merge(request.all());
      await reminder.save();
      return response.json(reminder);
    }
  
    async destroy({ params, response }) 
    {
      const reminder = await this.Reminder.find(params.id);
      await reminder.delete();
      return response.status(204).send();
    }
}

module.exports = ReminderController
