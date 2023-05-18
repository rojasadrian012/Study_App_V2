import { Component, inject, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AlertController, Platform, ToastController } from '@ionic/angular';
import axios from 'axios';

@Component({
  selector: 'app-theme-list',
  templateUrl: './theme-list.page.html',
  styleUrls: ['./theme-list.page.scss'],
})
export class ThemeListPage implements OnInit {
  temas: any = [];
  private platform = inject(Platform);
  public alertButtons = ['Aceptar', 'Cancelar'];

  constructor(private toastController: ToastController) {}

  ionViewWillEnter(): void {
    this.getThemes();
  }

  ngOnInit() {}

  getThemes() {
    axios
      .get('http://localhost:3000/themes/list')
      .then((result) => {
        if (result.data.success == true) {
          this.temas = result.data.temas;
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
    return isIos ? '' : '';
  }
  async presentToast(message: string) {
    const toast = await this.toastController.create({
      message: message,
      duration: 1500,
      position: 'bottom',
    });
    await toast.present();
  }
}
