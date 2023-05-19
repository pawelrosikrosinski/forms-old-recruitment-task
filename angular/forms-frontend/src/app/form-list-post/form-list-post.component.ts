import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormListComponent } from '../form-list/form-list.component';
import { FormListPost } from '../form-list-post';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-form-list-post',
  standalone: true,
  imports: [CommonModule],
  template: `
    
    <section>
    
      <div class="post">
      Form ID: {{master.forms_id}}<br>Template Name: {{master.formtemplates_name}}<br>
      
      <span>
      <button class="button" (click)="click_edit()">Edit</button>
      <button class="button" >Poll</button>
      </span>
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

 }
