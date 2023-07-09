import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-page-not-active',
  standalone: true,
  imports: [CommonModule],
  templateUrl: "./page-not-active.component.html",

  styleUrls: ['./page-not-active.component.css']
})
export class PageNotActiveComponent implements OnInit{

  id: number = 1
  private sub:any

  constructor(private route: ActivatedRoute) {}

  ngOnInit(): void {

    this.sub = this.route.params.subscribe(params => 
      this.id = params['forms_id'] )
      

  }


  
}
