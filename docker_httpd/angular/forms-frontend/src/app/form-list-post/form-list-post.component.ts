import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormListComponent } from '../form-list/form-list.component';
import { FormListPost } from '../form-list-post';
import { Router, RouterModule } from '@angular/router';
import {MatButtonModule} from '@angular/material/button';

@Component({
  selector: 'app-form-list-post',
  standalone: true,
  imports: [CommonModule, MatButtonModule],
  template: `
    
    <section>
    
      <div class="post">
      Form ID: {{master.forms_id}}<br>Template Name: {{master.formtemplates_name}}<br>
      
      <div class="flex">
      <button class="button" (click)="click_edit()" mat-button color="primary">Edit</button>
      <button class="button" (click)="click_poll()" mat-button color="primary">Poll</button>
      </div>
      </div>

     
      
    </section>
  `,
  styleUrls: ['./form-list-post.component.css']
})
export class FormListPostComponent {

  constructor(private router: Router) {}
  
  @Input() master!: FormListPost

  click_edit(){
    this.router.navigate(['/edit/' + this.master.forms_id]);
  }

  click_poll(){
    this.router.navigate(['/poll/' + this.master.forms_id]);
  }

 }
