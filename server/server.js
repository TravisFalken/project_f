const dotEnv = require('dotenv').config({ path: './config.env' });
const express = require('express');
const morgan = require('morgan');
const colors = require('colors');
const users = require('./routes/users');

const app = express();

/*=====================================
    Middleware 
======================================*/

//Set up morgan if app is running in dev mode
if (process.env.NODE_ENV == 'development') {
  app.use(morgan('dev'));
}

//Set up json middleware
app.use(express.json());

/*=============================
  Setup Server
=================================*/

//Add routes
app.use('/api/v1/users', users);

//Set up the listening port for api
const port = process.env.PORT || 3000;

//Start listening
const server = app.listen(
  port,
  console.log(
    `Server running in ${process.env.NODE_ENV} mode on port ${port}`.yellow.bold
  )
);
