import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import {MatIconModule} from '@angular/material/icon';
import {MatDividerModule} from '@angular/material/divider';
import {MatButtonModule} from '@angular/material/button';


@Component({
  selector: 'app-bar',
  standalone: true,
  imports: [CommonModule, MatButtonModule, MatDividerModule, MatIconModule],
  template: `
    <div class="bar">





      <button (click)="frontButton()" class="button" mat-raised-button color="accent">Home</button>



    <button (click)="addButton()" class="button" mat-raised-button color="accent">

    Add
  </button></div>
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
