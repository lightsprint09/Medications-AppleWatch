package de.hshn.mi.pita.model;

/**
 * This interface represents a Drug
 *
 * Created by Max on 07.04.15.
 */
public interface Drug extends PersistentObject{

    String getName();

    String getActiveSubstance();

    String getDoseOfSubstance();

    String getCompanyName();

    /**
     * We could think about to put the pictures directly on the watch
     *
     * @return
     */
    String getImagePath();

}
