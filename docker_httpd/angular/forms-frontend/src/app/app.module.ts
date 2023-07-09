import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { BarComponent } from './bar/bar.component';
import { FormListComponent } from './form-list/form-list.component';
import { HttpClientModule } from  '@angular/common/http';
import { RouterModule, Routes } from '@angular/router';
import { FormListPostComponent } from './form-list-post/form-list-post.component';
import { PageNotActiveComponent } from './page-not-active/page-not-active.component';
import { AppRoutingModule } from './app-routing.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

@NgModule({
  declarations: [
    AppComponent

  ],
  imports: [
    BrowserModule, BarComponent, FormListComponent, HttpClientModule, AppRoutingModule, BrowserAnimationsModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
