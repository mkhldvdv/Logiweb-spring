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

    @JoinColumn(name = "CITY_ID1", table = "CITIES", referencedColumnName = "CITY_NAME")
    private String city1;

    @JoinColumn(name = "CITY_ID2", table = "CITIES", referencedColumnName = "CITY_NAME")
    private String city2;

    @Column(name = "DISTANCE")
    private int distance;

    protected CityMap() {
    }

    public CityMap(String city1, String city2, int distance) {
        this.city1 = city1;
        this.city2 = city2;
        this.distance = distance;
    }

    public long getId() {
        return id;
    }

    public String getCity1() {
        return city1;
    }

    public void setCity1(String city1) {
        this.city1 = city1;
    }

    public String getCity2() {
        return city2;
    }

    public void setCity2(String city2) {
        this.city2 = city2;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CityMap cityMap = (CityMap) o;

        if (id != cityMap.id) return false;
        return distance == cityMap.distance;

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + distance;
        return result;
    }

    @Override
    public String toString() {
        return "CityMap{" +
                "id=" + id +
                ", city1='" + city1 + '\'' +
                ", city2='" + city2 + '\'' +
                ", distance=" + distance +
                '}';
    }
}
