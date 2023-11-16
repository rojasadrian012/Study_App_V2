const nodemailer = require('nodemailer');
const { sequelize } = require("../connection");
const { ThemesPropertiesModel } = require("../model/themes_properties.model");

const listar = async function (textoBuscar) {
  console.log("listar propiedades de temas");
  try {
    const themes_properties = await sequelize.query(`SELECT * 
      FROM themes_properties
      WHERE 1=1
        AND UPPER(property_name) LIKE UPPER('%${textoBuscar}%')
      ORDER BY id`);
    if (themes_properties && themes_properties[0]) {
      return themes_properties[0];
    } else {
      return [];
    }
  } catch (error) {
    console.log(error);
    throw error;
  }
};

const consultarPorCodigo = async function (codigo) {
  console.log("consultar 1 propiedad de tema por codigo");
  try {
    const themesPropertiesModelResult = await ThemesPropertiesModel.findByPk(
      codigo
    );
    if (themesPropertiesModelResult) {
      return themesPropertiesModelResult;
    } else {
      return [];
    }
  } catch (error) {
    console.log(error);
    throw error;
  }
};

const consultarPorCodigoTheme = async function (codigo) {
  console.log("consultar 1 propiedad de tema por codigo del tema");
  try {
    const themes_properties = await sequelize.query(`SELECT * 
                                                    FROM themes_properties
                                                    WHERE 1=1
                                                    AND theme_id=${codigo}
                                                    ORDER BY id`);
    if (themes_properties && themes_properties[0]) {
      return themes_properties[0];
    } else {
      return [];
    }

  } catch (error) {
    console.log(error);
    throw error;
  }
};

const actualizar = async function (
  id,
  theme_id,
  property_name,
  property_value
) {
  console.log("actualizar propiedad de tema");
  let themesPropertiesReturn = null;
  const data = { id, theme_id, property_name, property_value };
  try {
    let themesPropertiesExist = null;
    if (id) {
      themesPropertiesExist = await ThemesPropertiesModel.findByPk(id);
    }
    if (themesPropertiesExist) {
      themesPropertiesReturn = await ThemesPropertiesModel.update(data, {
        where: { id: id },
      });
      themesPropertiesReturn = data;
    } else {
      themesPropertiesReturn = await ThemesPropertiesModel.create(data);
    }
    return themesPropertiesReturn;
  } catch (error) {
    console.log(error);
    throw error;
  }
};

const eliminar = async function (codigo) {
  console.log("eliminar propiedad de tema");
  try {
    ThemesPropertiesModel.destroy(
      { where: { id: codigo } },
      { truncate: false }
    );
  } catch (error) {
    console.log(error);
    throw error;
  }
};


const agregarService = async function (data) {
  try {
    const newThemeProperty = await ThemesPropertiesModel.create({
      theme_id: data.theme_id,
      property_name: data.property_name,
      property_value: data.property_value
    });

    return newThemeProperty; // Devuelve la instancia creada
  } catch (error) {
    console.error("Error al insertar en la base de datos:", error);
    throw new Error("Error al insertar en la base de datos");
  }
};


const sendEmail = async (destinoEmail, subject, text) => {
  let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'correo aqui del remitente',
      pass: 'clave aqui, tutorial: https://www.youtube.com/watch?v=u3YIHs1Rx78'
    }
  });


  let mailOptions = {
    from: 'correo aqui del remitente',
    to: destinoEmail,
    subject: subject,
    text: text
  };

  try {
    let info = await transporter.sendMail(mailOptions);
    console.log('Correo enviado: ' + info.response);
    return info;
  } catch (error) {
    console.error('Error al enviar correo:', error);
    throw error;
  }
};




module.exports = {
  listar,
  busquedaPorCodigo: consultarPorCodigo,
  actualizar,
  eliminar,
  consultarPorCodigoTheme,
  agregarService,
  sendEmail
};
