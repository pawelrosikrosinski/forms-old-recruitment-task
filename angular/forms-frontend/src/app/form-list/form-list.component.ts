import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormListPostComponent } from '../form-list-post/form-list-post.component';
import { FormListPost } from '../form-list-post';
import { HttpClient } from '@angular/common/http';
import { RouterModule, Routes } from '@angular/router';

let li:any;

@Component({
  selector: 'app-form-list',
  standalone: true,
  imports: [CommonModule,  FormListPostComponent, FormListPostComponent],
  template: `
    <br><span>List of Forms:</span><app-form-list-post *ngFor="let master of FormList" [master] = "master"></app-form-list-post>
  `,
  styleUrls: ['./form-list.component.css']
})

export class FormListComponent implements OnInit{



  
  




  constructor(private http:HttpClient){}
    

 
  

    
    
  ngOnInit(): void {
    this.http.get('http://127.0.0.1:5000/get_forms_list').subscribe(Response => {
    console.log(Response)
    li=Response;
    
    console.log(li[0].formtemplates_name)

    for (const i in li){
   console.log(li[i])
   console.log("break")
    this.FormList = li
   
    }
  })}

  FormList: FormListPost [] = []


 
};

