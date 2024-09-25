'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class ReminderSchema extends Schema {
  up () {
    this.create('reminders', (table) => {
      table.increments()
      // table.integer('user_id').notNullable().unsigned().references('users.id').onDelete('CASCADE')
      table.string('title').notNullable()
      table.string('description').notNullable()
      table.string('observations').notNullable()
      table.datetime('timetable').notNullable()
      table.timestamps()
    })
  }

  down () {
    this.drop('reminders')
  }
}

module.exports = ReminderSchema
