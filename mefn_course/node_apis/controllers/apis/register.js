const express = require('express');
const router = express.Router();
const { check, validationResult } = require('express-validator');
const bcrypt = require('bcryptjs');

const jwtHandler = require('../middleware/jwt_handler');
const User = require('../../models/user');


// url : /api/register 
// method : POST 
// access : Public 
// desc : register a user

router.post('/', [
     check('name', "Name is Required").not().isEmpty(),
     check('email', "Please Include a Valid email").isEmail(),
     check('password', "Use a Strong password with 6 or more characters").isLength({ min : 6 }),
] ,async (req, res) => {
    // TODO : validate data 
    const error  = validationResult(req);
    // TODO : Send Errors
    if(!error.isEmpty()){
        return res.status(400).json({ 'errors' : error.array() });
    }

    var { name, email, password } = req.body;
    // TODO : Check if a user exists
    try {
        let user = await User.findOne({ email : email });
        if(user){
            return res.status(400).json({ 'errors' : [{ msg : "User already exists !" }] });
        }
        // TODO : encrypt the password
        const salt = await bcrypt.genSalt(10);
        password = await bcrypt.hash(password, salt);


        // CREATE A USER
        user = new User({
            name,
            email,
            password
        });
        await user.save();

        // TODO : login the user

        var token = await jwtHandler.generateToken(user.id);
        return res.json({ token });

    } catch (error) {
            console.error(error);
            return res.send(500).json("Server error");
    }
    // TODO : send Token
})  

module.exports = router;