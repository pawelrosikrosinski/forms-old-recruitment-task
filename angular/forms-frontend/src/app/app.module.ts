import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { BarComponent } from './bar/bar.component';
import { AddIconComponent } from './add-icon/add-icon.component';
import { FormListComponent } from './form-list/form-list.component';
@NgModule({
  declarations: [
    AppComponent
    
  ],
  imports: [
    BrowserModule, BarComponent, AddIconComponent, FormListComponent
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
