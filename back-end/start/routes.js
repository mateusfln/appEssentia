'use strict'

/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| Http routes are entry points to your web application. You can create
| routes for different URL's and bind Controller actions to them.
|
| A complete guide on routing is available here.
| http://adonisjs.com/docs/4.1/routing
|
*/

/** @type {typeof import('@adonisjs/framework/src/Route/Manager')} */
const Route = use('Route')

Route.get('/', () => {return { greeting: 'Hello world in JSON' }})

Route.group(() => {
    Route.get('/', 'ReminderController.index');
    Route.post('/', 'ReminderController.store');
    Route.get('/:id', 'ReminderController.show');
    Route.put('/:id', 'ReminderController.update');
    Route.delete('/:id', 'ReminderController.destroy');
}).prefix('api/v1/reminders');

Route.group(() => {
    Route.get('/', 'UserController.index');
    Route.post('/', 'UserController.store');
    Route.get('/:id', 'UserController.show');
    Route.put('/:id', 'UserController.update');
    Route.delete('/:id', 'UserController.destroy');
}).prefix('api/v1/users');
