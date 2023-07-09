import { Component } from '@angular/core';



@Component({
  selector: 'app-root',
  //imports:[],
  template: '<div><app-bar></app-bar><router-outlet></router-outlet></div>',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'forms-frontend';
  isOn = 1;
}
