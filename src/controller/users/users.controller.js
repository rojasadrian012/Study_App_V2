const { sequelize } = require("../../connection");
const { UserModel } = require("../../model/user.model");
const UserService = require("../../service/user.service");

//si se va a usar await la funcion debe ser async
//con f2 cambiar el listar a listarController, corregir en route tb
const listar = async function (req, res) {
  console.log("listar usuarios controller");
  try {
    //el or es para que si retorna undefined me traiga vacio
    const users = await UserService.listar(req.query.filtro || "");
    if (users) {
      res.json({
        success: true,
        usuarios: users,
      });
    } else {
      res.json({
        success: true,
        usuarios: [],
      });
    }
  } catch (error) {
    console.log(error);
    res.json({
      success: false,
      error: error.message,
    });
  }
};

const consultarPorCodigo = async function (req, res) {
  console.log("consultar 1 usuario por codigo controller");
  try {
    const userModelResult = await UserService.busquedaPorCodigo(
      req.params.filtro || ""
    );
    if (userModelResult) {
      res.json({
        success: true,
        usuario: userModelResult,
      });
    } else {
      res.json({
        success: true,
        usuario: [],
      });
    }
  } catch (error) {
    console.log(error);
    res.json({
      success: false,
      error: error.message,
    });
  }
};

const actualizar = async function (req, res) {
  console.log("actualizar usuarios controller");
  let userReturn = null; //guarda el user que se va a incluir o editar
  try {
    userReturn = await UserService.actualizar(
      req.body.id,
      req.body.name,
      req.body.last_name,
      req.body.avatar,
      req.body.email,
      req.body.password,
      req.body.deleted
    );
    res.json({
      success: true,
      user: userReturn,
    });
  } catch (error) {
    console.log(error);
    res.json({
      success: false,
      error: error.message,
    });
  }
};

const eliminar = async function (req, res) {
  console.log("eliminar usuarios controller");
  //res.send("eliminar de usuarios");
  //Borrado fisico
  //UserModel.destroy(req.params.id);
  try {
    await UserService.eliminar(req.params.filtro || "");
    res.json({
      success: true,
    });
  } catch (error) {
    console.log(error);
    res.json({
      success: false,
      error: error.message,
    });
  }
};

//lo que esta entre la llave es json
module.exports = {
  listar,
  busquedaPorCodigo: consultarPorCodigo,
  actualizar,
  eliminar,
};
