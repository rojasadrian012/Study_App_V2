import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Platform } from '@ionic/angular';
import axios from 'axios';

@Component({
  selector: 'app-theme-details',
  templateUrl: './theme-details.page.html',
  styleUrls: ['./theme-details.page.scss'],
})
export class ThemeDetailsPage implements OnInit {
  private platform = inject(Platform);
  themesProperties: any = []; //variable para guardar la propiedades
  private activatedRoute = inject(ActivatedRoute); //para capturar el id en la url
  isOpen: boolean = false; //para abrir y cerrar el modal
  newThemeProperty = {
    theme_id: 0,
    property_name: '',
    property_value: ''
  }; //para guardar los valores de lo que se va a insertar

  constructor() { }

  ngOnInit() {
    const id_theme = this.activatedRoute.snapshot.paramMap.get('id') as string; //captura id al cargar la pagina
    this.getThemesProperties(id_theme)
  }

  getBackButtonText() {
    const isIos = this.platform.is('ios');
    return isIos ? '' : '';
  }

  getThemesProperties(id: string) {
    const token = localStorage.getItem('token');
    const config = {
      headers: {
        Authorization: token,
      },
    };
    axios
      .get('http://localhost:3000/themes_properties/buscarPorTema/' + id, config)//ruta en el backend
      .then((result) => {
        if (result.data.success == true) {
          this.themesProperties = result.data.themes_properties; //aqui se guarda los datos que vienen del backend
        } else {
          console.log(result.data);
        }
      })
      .catch((error) => {
        console.log(error.message);
      });
  }

  eliminarProperty(themesPropertyId: string, themeId: any) {
    const token = localStorage.getItem('token');
    const config = {
      headers: {
        Authorization: token,
      },
    };

    axios
      .delete('http://localhost:3000/themes_properties/delete/' + themesPropertyId, config)
      .then((result) => {
        if (result.data.success == true) {
          this.getThemesProperties(themeId) //Si sale bien actualizamos las propiedades
        } else {
          console.log(result.data.error);
        }
      })
      .catch((error) => {
        console.log(error.message);

      });
  }

  abrirCerrarModal() {
    this.isOpen = !this.isOpen
  }

  guardarThemeProperty() {
    this.newThemeProperty.theme_id = this.themesProperties[0].theme_id  //id del theme actual
    const token = localStorage.getItem('token');
    const config = {
      headers: {
        Authorization: token,
      },
    };

    axios.post('http://localhost:3000/themes_properties/update', this.newThemeProperty, config)
      .then((result) => {
        if (result.data.success === true) {
          const id = this.newThemeProperty.theme_id.toString();
          this.newThemeProperty.theme_id = 0
          this.newThemeProperty.property_name = ''
          this.newThemeProperty.property_value = ''
          this.abrirCerrarModal()
          this.getThemesProperties(id) //actulizar lista de propiedades
        } else {
          console.log(result.data.error);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  }


}
