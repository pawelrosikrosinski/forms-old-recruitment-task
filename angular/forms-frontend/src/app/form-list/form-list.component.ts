import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormListPostComponent } from '../form-list-post/form-list-post.component';
import { FormListPost } from '../form-list-post';

@Component({
  selector: 'app-form-list',
  standalone: true,
  imports: [CommonModule,  FormListPostComponent, FormListPostComponent],
  template: `
    <app-form-list-post [master] = "FormList" ></app-form-list-post>
  `,
  styleUrls: ['./form-list.component.css']
})
export class FormListComponent {


  FormList: FormListPost = {
    
    id: 1,
    template_name: "VehicleDeal"
  }
};

