import { CommonModule } from '@angular/common';
import { Component, inject, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { IonicModule, Platform, ToastController } from '@ionic/angular';
import { DataService, Message } from '../services/data.service';
import axios from 'axios';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {
  public message!: Message;
  private data = inject(DataService);
  private activatedRoute = inject(ActivatedRoute);
  private platform = inject(Platform);
  usuario: any = '';
  isModal: boolean = false
  emailRecuperacion: string = ''
  usuarios: any = []

  constructor(
    private toastController: ToastController,
    private router: Router
  ) { }

  ngOnInit() {
    //con este comando se recupera el id que se pasa
    const id = this.activatedRoute.snapshot.paramMap.get('id') as string;
    axios
      .get('http://localhost:3000/users/buscarPorCodigo/0')
      .then((result) => {
        if (result.data.success == true) {
          if (result.data.usuario != null) {
            this.usuario = result.data.usuario;

          } else {
            this.usuario = {};
          }
        } else {
          console.log(result.data.error);
        }
      })
      .catch((error) => {
        console.log(error.message);
      });
  }

  getBackButtonText() {
    const isIos = this.platform.is('ios');
    return isIos ? 'Inbox' : '';
  }

  loginUser() {
    console.log('usuario: ', this.usuario);
    var data = {
      email: this.usuario.email,
      password: this.usuario.password,
    };
    axios
      .post('http://localhost:3000/user/login', data)
      .then(async (result) => {
        if (result.data.success == true) {
          this.presentToast('Bienvenido a StudyApp');
          localStorage.setItem('token', result.data.token);
          localStorage.setItem('user_id', result.data.user_id);
          this.router.navigate(['/home']);
        } else {
          this.presentToast(result.data.error);
        }
      })
      .catch(async (error) => {
        this.presentToast(error.message);
      });
  }
  ionViewWillEnter(): void {
    //verificar si el usuario esta logueado
    let token = localStorage.getItem('token');
    if (token) {
      this.router.navigate(['/home']);
    }
  }

  async presentToast(message: string) {
    const toast = await this.toastController.create({
      message: message,
      duration: 1500,
      position: 'bottom',
    });
    await toast.present();
  }

  showRecoverPasswordModal() {
    this.isModal = !this.isModal;
  }

  getUsers() {
    let token = localStorage.getItem('token');
    let config = {
      headers: {
        Authorization: token,
      },
    };
    axios
      .get('http://localhost:3000/users/list', config)
      .then((result) => {
        if (result.data.success == true) {
          this.usuarios = result.data.usuarios;
          const usuario = this.verificarCorreo()

          if (usuario)
            this.crearNuevaPassword(usuario.id)
          else
            this.presentToast("No existe el usuario");

        } else {
          console.log(result.data.error);
        }
      })
      .catch((error) => {
        console.log(error.message);
      });
  }

  verificarCorreo() {
    return this.usuarios.find((usuario: any) => usuario.email === this.emailRecuperacion);
  }



  enviarEmail(newPassword: any) {
    let token = localStorage.getItem('token');
    let config = {
      headers: {
        Authorization: token,
      },
    };

    const dataSend = {
      destinoEmail: this.emailRecuperacion,
      subject: 'Recuperación de Contraseña para StudyAPP',
      html: `
      <html>
      <head>
        <style>
          body {
            font-family: 'Arial', sans-serif;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
          }
          .header, .footer {
            background-color: #f3f3f3;
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
          }
          .content {
            padding: 20px;
          }
          .content-block {
            background-color: #f9f9f9;
            border-left: 4px solid #4CAF50;
            margin: 15px 0;
            padding: 10px;
            font-size: 16px;
          }
          .important {
            color: black;
            font-weight: bold;
          }
          .important_V2 {
            color: #ff5252;
            font-weight: bold;
          }
          .footer {
            font-size: 12px;
          }
        </style>
      </head>
      <body>
        <div class="header">
          <h1 style="margin:0;">StudyAPP</h1>
        </div>
        <div class="content">
          <div class="content-block">
            <p style="color: black">Estimado usuario <strong>${newPassword.name} ${newPassword.lastName}</strong> de <strong>StudyAPP</strong>.</p>
            <p style="color: black">Hemos recibido una solicitud para restablecer su contraseña. A continuación, le proporcionamos su nueva contraseña temporal:</p>
            <p class="important">Nueva Contraseña: <span class="important_V2">${newPassword.newPassword}</span></p>
            <p style="color: black">Por razones de seguridad, le recomendamos cambiar esta contraseña temporal tan pronto como inicie sesión en su cuenta. Si no realizó esta solicitud o necesita ayuda adicional, póngase en contacto con nuestro equipo de soporte.</p>
          </div>
          <div class="content-block">
            <p>¡Gracias por usar StudyAPP!</p>
          </div>
        </div>
        <div style="color: black" class="footer">
          Atentamente,<br/>
          El equipo de StudyAPP.
        </div>
      </body>
      </html>
      `
    };

    axios.post('http://localhost:3000/themes_properties/enviaremail', dataSend, config)
      .then((result) => {
        if (result.data.success) {
          this.presentToast('Email enviado!');
        }
      })
      .catch((error) => {
        console.log(error);
        this.presentToast('Error: ' + error.message);
      });
  }

  crearNuevaPassword(id: number) {
    let token = localStorage.getItem('token');
    let config = {
      headers: {
        Authorization: token,
      },
    };
    axios
      .get('http://localhost:3000/users/new-password/' + id, config)
      .then((result) => {
        if (result.data.success == true) {
          this.enviarEmail(result.data.newPassword)
        } else {
          console.log(result.data.error);
        }
      })
      .catch((error) => {
        console.log(error.message);
      });
  }

  recuperarPassword() {
    this.getUsers()
  }




}
