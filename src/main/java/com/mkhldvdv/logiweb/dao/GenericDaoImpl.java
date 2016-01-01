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
    @PersistenceContext
    protected EntityManager em;

    public GenericDaoImpl(){
        ParameterizedType genericSuperclass = (ParameterizedType) getClass()
                .getGenericSuperclass();
        this.entityClass = (Class) genericSuperclass
                .getActualTypeArguments()[0];
    }

    @Override
    public T create(T t) {
        em.persist(t);
        return t;
    }

    @Override
    public T update(T t) {
        em.merge(t);
        return t;
    }

    @Override
    public void remove(T t) {
        t = em.merge(t);
        em.remove(t);
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
}