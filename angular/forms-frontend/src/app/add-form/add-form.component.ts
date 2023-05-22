import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TemplateList } from '../template-list';
import { HttpClient } from '@angular/common/http';
import { MatRadioModule } from '@angular/material/radio'; 
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';

let li: any

@Component({
  selector: 'app-add-form',
  standalone: true,
  imports: [CommonModule,FormsModule, MatRadioModule,],
  templateUrl: './add-form.component.html',
  styleUrls: ['./add-form.component.css']
})
export class AddFormComponent implements OnInit{

  constructor(private http: HttpClient, private router: Router) {}


  ngOnInit(): void {
    this.http.get('http://127.0.0.1:5000/get_formtemplates').subscribe(Response => {
    console.log(Response)
    li=Response;
    
    console.log(li[0].formtemplate_name)

    for (const i in li){
   console.log(li[i])
   console.log("break")
    this.templateList = li
    
    }
  })}

  templateList: TemplateList [] = []

  favoriteSeason!: string;
 

  template_chosen(){

    console.log(this.favoriteSeason)

    this.http.get('http://127.0.0.1:5000/create_new_form?formtemplates_id=' + this.favoriteSeason).subscribe(Response => {
       console.log(Response)
    li=Response;
    
    console.log(li)

    this.router.navigate(['edit/' + li])

    
      
      
     

  })

  }
  


}
