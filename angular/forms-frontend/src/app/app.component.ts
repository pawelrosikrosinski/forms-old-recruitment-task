import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  //imports:[],
  template: "<app-bar></app-bar><app-form-list></app-form-list>",
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'forms-frontend';
}
