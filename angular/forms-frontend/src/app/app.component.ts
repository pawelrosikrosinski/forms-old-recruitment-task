import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  //imports:[],
  template: "<div><app-bar></app-bar><br>Form List: <br><app-form-list></app-form-list></div>",
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'forms-frontend';
}
