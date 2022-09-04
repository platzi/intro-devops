import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class JavatechieCovid19Service {

  constructor(private http:HttpClient) { }


  public covid19Reports(){
  return  this.http.get("https://corona.lmao.ninja/v2/countries");
  }
}
