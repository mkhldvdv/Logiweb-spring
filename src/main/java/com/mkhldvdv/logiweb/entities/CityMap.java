package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "MAP")
public class CityMap implements Serializable {
    @Id
    @Column(name = "MAP_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "map_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "CITY_ID1")
    private byte city1;

    @Column(name = "CITY_ID2")
    private byte city2;

    @Column(name = "DISTANCE")
    private int distance;

//    @JoinColumn(name = "CITY_ID", table = "CITIES", referencedColumnName = "CITY_NAME")
//    private String city1Str;
//
//    @JoinColumn(name = "CITY_ID", table = "CITIES", referencedColumnName = "CITY_NAME")
//    private String city2Str;

    public CityMap() {
    }

    public CityMap(byte city1, byte city2, int distance) {
        this.city1 = city1;
        this.city2 = city2;
        this.distance = distance;
    }

    public long getId() {
        return id;
    }

    public long getCity1() {
        return city1;
    }

    public void setCity1(byte city1) {
        this.city1 = city1;
    }

    public long getCity2() {
        return city2;
    }

    public void setCity2(byte city2) {
        this.city2 = city2;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public void setId(long id) {
        this.id = id;
    }

//    public String getCity1Str() {
//        return city1Str;
//    }
//
//    public void setCity1Str(String city1Str) {
//        this.city1Str = city1Str;
//    }
//
//    public String getCity2Str() {
//        return city2Str;
//    }
//
//    public void setCity2Str(String city2Str) {
//        this.city2Str = city2Str;
//    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CityMap cityMap = (CityMap) o;

        return id == cityMap.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "CityMap{" +
                "id=" + id +
                ", city1=" + city1 +
                ", city2=" + city2 +
                ", distance=" + distance +
//                ", city1Str='" + city1Str + '\'' +
//                ", city2Str='" + city2Str + '\'' +
                '}';
    }
}
