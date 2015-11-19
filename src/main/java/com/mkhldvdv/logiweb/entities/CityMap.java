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
            valueColumnName = "SEQ_VALUE", pkColumnValue = "map_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CITY_ID1")
    private City city1;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CITY_ID2")
    private City city2;

    @Column(name = "DISTANCE")
    private int distance;

    public CityMap() {
    }

    public CityMap(City city1, City city2, int distance) {
        this.city1 = city1;
        this.city2 = city2;
        this.distance = distance;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public City getCity1() {
        return city1;
    }

    public void setCity1(City city1) {
        this.city1 = city1;
    }

    public City getCity2() {
        return city2;
    }

    public void setCity2(City city2) {
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
                ", city1=" + city1 +
                ", city2=" + city2 +
                ", distance=" + distance +
                '}';
    }
}
