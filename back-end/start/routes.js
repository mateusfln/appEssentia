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

const defineRestfulRoutes = (resource) => {
    const resourceName = resource.toLowerCase();
    const controllerName = `${resource}Controller`;

    Route.group(() => {
        Route.get('/', `${controllerName}.index`).as(`${resourceName}.index`);
        Route.post('/', `${controllerName}.store`).as(`${resourceName}.store`);
        Route.get('/:id', `${controllerName}.show`).as(`${resourceName}.show`);
        Route.put('/:id', `${controllerName}.update`).as(`${resourceName}.update`);
        Route.delete('/:id', `${controllerName}.destroy`).as(`${resourceName}.destroy`);
    }).prefix(`api/v1/${resourceName}s`);
};

defineRestfulRoutes('Reminder');
defineRestfulRoutes('User');
