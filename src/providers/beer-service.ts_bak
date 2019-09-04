import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class BeerService {
//  public API = 'http://spring-boot-ionic-example-dev.13.94.25.165.nip.io';
//  public API = 'http://10.0.2.2:8080';
//  public API = 'http://localhost:8080';
  public API = '@@@app_server_url@@@';
  public BEER_API = this.API + '/beers';

  constructor(public http: HttpClient) {
  }

  getGoodBeers(): Observable<any> {
    return this.http.get(this.API + '/good-beers');
  }

  get(id: string) {
    return this.http.get(this.BEER_API + '/' + id);
  }

  save(beer: any): Observable<any> {
    let result: Observable<Object>;
    if (beer['href']) {
      result = this.http.put(beer.href, beer);
    } else {
      result = this.http.post(this.BEER_API, beer)
    }
    return result.catch(error => Observable.throw(error));
  }

  remove(id: string) {
    return this.http.delete(this.BEER_API + '/' + id);
  }
}
