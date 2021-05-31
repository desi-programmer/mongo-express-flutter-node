const express = require('express');
const cors = require('cors');
const app = express();

// Connect to databse 
require('./config/connect_database')();

// Body parser
app.use(express.json({ extended : true }));
app.use(cors());


app.get('/', (req, res) => {
    res.send("Hii");
});


app.use('/api/register', require('./controllers/apis/register'));
app.use('/api/login', require('./controllers/apis/login'));
app.use('/api/logout', require('./controllers/apis/logout'));
app.use('/api/profile', require('./controllers/apis/profile'));


app.use('/api/book', require('./controllers/apis/book-service'));
app.use('/api/bookings', require('./controllers/apis/booking_history'));


const PORT = process.env.PORT || 3000;
app.listen(PORT, ()=> console.log(`Server Started at PORt : ${PORT}`),);