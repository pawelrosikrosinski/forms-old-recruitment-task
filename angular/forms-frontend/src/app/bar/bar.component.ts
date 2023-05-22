import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
//import { AddIconComponent } from '../add-icon/add-icon.component';
import { Router } from '@angular/router';

@Component({
  selector: 'app-bar',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="bar"> 
      <button (click)="addButton()" class="button">Add</button>
      <button (click)="frontButton()" class="button">MAIN</button>
    </div>
  `,
  styleUrls: ['./bar.component.css']
})
export class BarComponent {

  constructor(private router: Router) {}

  addButton(){
    this.router.navigate(['add']);
  }

  frontButton(){
    this.router.navigate(['']);
  }

}
