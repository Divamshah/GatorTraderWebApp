var express = require("express");
var router = express.Router();
var db = require('../db');

router.get('/:id', function(req, res, next) {
    var id = req.params.id;
    db.any(`SELECT * FROM category`)
    .then( cat => db.any(`SELECT * FROM item WHERE item_id=` + id)
    .then( data => {
        var category;
        cat.forEach(element => {
            if (element.category_id == data[0].category_id)
                category = element.category_name;
        });
        res.render( 'detailsPage', {data: data[0], categories: cat, category: category} );
    }));
});

module.exports = router;