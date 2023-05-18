import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AddIconComponent } from '../add-icon/add-icon.component';

@Component({
  selector: 'app-bar',
  standalone: true,
  imports: [CommonModule, AddIconComponent],
  template: `
    <div class="bar"> 
      <app-add-icon></app-add-icon>
    </div>
  `,
  styleUrls: ['./bar.component.css']
})
export class BarComponent {

}
