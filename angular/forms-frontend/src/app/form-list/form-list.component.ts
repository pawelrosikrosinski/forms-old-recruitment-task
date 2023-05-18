import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormListPostComponent } from '../form-list-post/form-list-post.component';
import { FormListPost } from '../form-list-post';
import { HttpClient } from '@angular/common/http';


@Component({
  selector: 'app-form-list',
  standalone: true,
  imports: [CommonModule,  FormListPostComponent, FormListPostComponent],
  template: `
    <app-form-list-post [master] = "FormList" ></app-form-list-post>
  `,
  styleUrls: ['./form-list.component.css']
})


export class FormListComponent implements OnInit{



  
  
  li:any;
lis=[];


  constructor(private http:HttpClient){
    




  }
  ngOnInit(): void {
    this.http.get('http://127.0.0.1:5000/get_forms_list').subscribe(Response => {
    console.log(Response)
    this.li=Response;
    this.lis=this.li.test;
    console.log(this.lis[0])
  })}

  FormList: FormListPost = {
    
    id: 1,
    template_name: "VehicleDeal",
    //list: abc,
  }


 
};

