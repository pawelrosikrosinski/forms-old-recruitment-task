import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormListComponent } from '../form-list/form-list.component';
import { FormListPost } from '../form-list-post';
@Component({
  selector: 'app-form-list-post',
  standalone: true,
  imports: [CommonModule],
  template: `
    
    <section>
    
      <div class="post">
      Form ID: {{master.id}}<br>Template Name: {{master.template_name}}<br>
      
      <span>
      <button class="button">Edit</button>
      <button class="button">Poll</button>
      </span>
      </div>

     
      
    </section>
  `,
  styleUrls: ['./form-list-post.component.css']
})
export class FormListPostComponent {
  
  @Input() master!: FormListPost

 }
