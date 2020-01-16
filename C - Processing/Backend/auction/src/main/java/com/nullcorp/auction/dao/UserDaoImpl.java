package com.nullcorp.auction.dao;

import com.nullcorp.auction.entity.User;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl implements UserDao {
  
    @Autowired
    private EntityManager entityManager;

    private Session getSession() {
        return entityManager.unwrap(Session.class);
    }

    @Override
    public List<User> findAll() {
        Query q = getSession().createNamedQuery("User.findAll");
        List<User> list = q.getResultList();
        return list;
    }

    @Override
    public void createOrUpdate(User u) {
        getSession().saveOrUpdate(u);
    }

    @Override
    public User findById(Integer id) {
        return (User) getSession().get(User.class, id);
        
    }

    @Override
    public void delete(Integer id) {
        Query q = getSession().createNamedQuery("User.deleteById");
        q.setParameter("id", id);
        q.executeUpdate();
    }

    @Override
    public List<User> findByUsername(String searchName) {
        Query q = getSession().createNamedQuery("User.findByUsername");
        q.setParameter("username", searchName+"%");
        return q.getResultList();
    }

    @Override
    public User findUserByUsername(String username) {
        Query q = getSession().createQuery("SELECT u FROM User u WHERE u.username=:name");
        q.setParameter("name", username);
        User user = null;
        try{
            user = (User)q.getSingleResult();
        }catch(NoResultException e){
            System.out.println("There is no result");
            user = null;
        }
        return user;
    }

    @Override
    public void save(User user) {
        getSession().save(user);
    }

}
