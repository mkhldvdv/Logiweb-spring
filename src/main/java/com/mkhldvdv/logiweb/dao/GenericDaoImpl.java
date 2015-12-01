package com.mkhldvdv.logiweb.dao;


import javax.persistence.*;
import java.lang.reflect.ParameterizedType;
import java.util.List;
/*
* Realization of GenericDao interface
* */
public abstract class GenericDaoImpl<T> implements GenericDao<T> {

    /**
     * Field that describes any entity, using in this class.
     */
    protected Class entityClass;
    protected EntityManager em;

    public GenericDaoImpl(){
        ParameterizedType genericSuperclass = (ParameterizedType) getClass()
                .getGenericSuperclass();
        this.entityClass = (Class) genericSuperclass
                .getActualTypeArguments()[0];
    }

    @Override
    public T create(T t) {
        try {
            em.persist(t);
            return t;
        } finally {
//            em.close();
        }
    }

    @Override
    public T update(T t) {
        try {
            em.merge(t);
            return t;
        } finally {
//            em.close();
        }
    }

    @Override
    public void remove(T t) {
        try {
            t = em.merge(t);
            em.remove(t);
        } finally {
//            em.close();
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public T getById(Long id) {
        return (T) em.find(entityClass, id);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<T> getAll() {
        TypedQuery<T> query = em.createQuery("from " + entityClass.getName(), entityClass);
        return query.getResultList();
    }

    public EntityManager getEm() {
        return em;
    }

    public void setEm(EntityManager em) {
        this.em = em;
    }
}
