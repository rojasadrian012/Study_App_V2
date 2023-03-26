const userController = require('../../controller/users/users.controller')
//require es como un import para referenciar archivos

module.exports = function(app){
    app.get("/users/list", userController.listar);
    app.get("/users/buscarPorCodigo/:filtro", userController.busquedaPorCodigo);
    app.post("/users/update", userController.actualizar);
    app.delete("/users/delete/:filtro", userController.eliminar);
}